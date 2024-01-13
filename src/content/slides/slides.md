---
title: Test Slides based on official examples
categories:
  - slides
---

## Just some basic test slides

Use the [official slides](https://revealjs.com) for more information and other more advanced examples.

Note:
Here

---

## Code highlighting with different lines

<pre><code class="hljs" data-line-numbers="1|1,3|2-3">
func main() {

return 0
}
</code></pre>

---

<section data-background-iframe="../" data-background-interactive>
  <div style="position: absolute; width: 40%; right: 0; box-shadow: 0 1px 4px rgba(0,0,0,0.5), 0 5px 25px rgba(0,0,0,0.2); background-color: rgba(0, 0, 0, 0.9); color: #fff; padding: 20px; font-size: 20px; text-align: left;">
    <h2>Iframe Backgrounds</h2>
    <p>IFrame example from reveal.js sample. Using a local path for ease.</p>
  </div>
</section>

---

## Fragment changes

<p class="fragment grow">grow</p>
<p class="fragment shrink">shrink</p>
<p class="fragment strike">strike</p>
<p class="fragment fade-out">fade-out</p>

---

## Fragment changes pt. 2

<p class="fragment fade-up">fade-up (also down, left and right!)</p>
<p class="fragment fade-in-then-out">fades in, then out when we move to the next step</p>
<p class="fragment fade-in-then-semi-out">fades in, then obfuscate when we move to the next step</p>
<p class="fragment highlight-current-blue">blue only once</p>
<p class="fragment highlight-red">highlight-red</p>
<p class="fragment highlight-green">highlight-green</p>
<p class="fragment highlight-blue">highlight-blue</p>
