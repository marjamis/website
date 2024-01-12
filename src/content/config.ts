import { defineCollection, z } from 'astro:content';

const posts = defineCollection({
	type: 'content',
	// Type-check frontmatter using a schema
	schema: z.object({
		title: z.string(),
		description: z.string(),
		// Transform string to Date object
		publishDate: z.coerce.date(),
		updatedDate: z.coerce.date().optional(),
		heroImage: z.string().optional(),
	}),
});

const fit_together = defineCollection({
	type: 'content',
	// Type-check frontmatter using a schema
	schema: z.object({
		title: z.string(),
		resources: z.object({
			title: z.string(),
			description: z.string().optional(),
			link: z.string().optional(),
		}).array().optional(),
	}),
});

export const collections = {
	posts: posts,
	fit_together: fit_together,
};
