Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5553D1A004B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 10:20:28 +1100 (AEDT)
Message-ID: <1455232599.3767.5.camel@infradead.org>
Subject: Re: [PATCH v2 0/4] powerpc/ps3: gelic_udbg: drop local versions of
 network data structs
From: Geoff Levand <geoff@infradead.org>
To: Luis Henriques <luis.henriques@canonical.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: Joe Perches <joe@perches.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>,  linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <1454970427-23017-1-git-send-email-luis.henriques@canonical.com>
References: <1454970427-23017-1-git-send-email-luis.henriques@canonical.com>
Content-Type: text/html; charset="utf-8"
Mime-Version: 1.0
Date: Thu, 11 Feb 2016 23:20:18 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<html><head><style id="-x-evo-style-a" type="text/css">a { cursor: text; }</style><style id="-x-evo-a-color-style" type="text/css">a { color: #569be4; }</style><style id="-x-evo-a-color-style-visited" type="text/css">a.-x-evo-visited-link { color: #569be4; }</style><style id="-x-evo-quote-style" type="text/css">.-x-evo-quoted { -webkit-user-select: none; }</style><style id="-x-evo-composer-sheet" media="screen" type="text/css">body {
  font-family: 'Monospace';
  font-size: 11pt;
  font-weight: 400;
  font-style: normal;
  -webkit-line-break: after-white-space;
}
pre,code,.pre {
  font-family: 'Monospace';
  font-size: 11pt;
  font-weight: 400;
  font-style: normal;
}p,pre,code,address {
  margin: 0;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
td:before {
  content: "​";}
img {
  height: inherit; 
  width: inherit; 
}
span.-x-evo-resizable-wrapper:hover {
  outline: 1px dashed red; 
  resize: both; 
  overflow: hidden; 
  display: inline-block; 
}
td:hover {
  outline: 1px dotted red;
}
.-x-evo-plaintext-table {
  border-collapse: collapse;
  width: 71ch;
}
.-x-evo-plaintext-table td{
  vertical-align: top;
}
td > * {
  display : inline-block;
}
ul[data-evo-plain-text]{
  list-style: outside none;
  -webkit-padding-start: 3ch; 
}
ul[data-evo-plain-text] > li{
  list-style-position: outside;
  text-indent: -2ch;
}
ul[data-evo-plain-text] > li::before {
  content: "* ";
}
ul[data-evo-plain-text].-x-evo-indented {
  -webkit-padding-start: 3ch; 
}
ul:not([data-evo-plain-text]),ol > li.-x-evo-align-center{
  list-style-position: inside;
}
ul:not([data-evo-plain-text]),ol > li.-x-evo-align-right{
  list-style-position: inside;
}
ul:not([data-evo-plain-text]),ol > li{
  text-indent: -3ch;
  list-style-position: inside;
}
ol{
  -webkit-padding-start: 6ch; 
}
ol.-x-evo-indented{
  -webkit-padding-start: 3ch; 
}
.-x-evo-align-left {
  text-align: left; 
}
.-x-evo-align-center {
  text-align: center; 
}
.-x-evo-align-right {
  text-align: right; 
}
ol,ul {
  -webkit-margin-before: 0em; 
  -webkit-margin-after: 0em; 
}
blockquote {
  -webkit-margin-before: 0em; 
  -webkit-margin-after: 0em; 
}
a {
  word-wrap: break-word; 
  word-break: break-all; 
}
blockquote[type=cite] {
  padding: 0.0ex 0ex;
  margin: 0ex;
  -webkit-margin-start: 0em; 
  -webkit-margin-end : 0em; 
  color: #737373 !important; 
}
.-x-evo-quote-character {
  color: rgb(114,159,207);
}
.-x-evo-quote-character+.-x-evo-quote-character{
  color: rgb(173,127,168);
}
.-x-evo-quote-character+.-x-evo-quote-character+.-x-evo-quote-character{
  color: rgb(138,226,52);
}
.-x-evo-quote-character+.-x-evo-quote-character+.-x-evo-quote-character+.-x-evo-quote-character{
  color: rgb(252,175,62);
}
.-x-evo-quote-character+.-x-evo-quote-character+.-x-evo-quote-character+.-x-evo-quote-character+.-x-evo-quote-character{
  color: rgb(233,185,110);
}
blockquote[type=cite]:not(.-x-evo-plaintext-quoted) {
  padding: 0ch 1ch 0ch 1ch;
  margin: 0ch;
  border-width: 0px 2px 0px 2px;
  border-style: none solid none solid;
  border-radius: 2px;
}
blockquote[type=cite]:not(.-x-evo-plaintext-quoted) {
  border-color: rgb(114,159,207);
}
blockquote[type=cite]:not(.-x-evo-plaintext-quoted) blockquote[type=cite]:not(.-x-evo-plaintext-quoted) {
  border-color: rgb(173,127,168);
}
blockquote[type=cite]:not(.-x-evo-plaintext-quoted) blockquote[type=cite]:not(.-x-evo-plaintext-quoted) blockquote[type=cite]:not(.-x-evo-plaintext-quoted) {
  border-color: rgb(138,226,52);
}
blockquote[type=cite]:not(.-x-evo-plaintext-quoted) blockquote[type=cite]:not(.-x-evo-plaintext-quoted) blockquote[type=cite]:not(.-x-evo-plaintext-quoted) blockquote[type=cite]:not(.-x-evo-plaintext-quoted) {
  border-color: rgb(252,175,62);
}
blockquote[type=cite]:not(.-x-evo-plaintext-quoted) blockquote[type=cite]:not(.-x-evo-plaintext-quoted) blockquote[type=cite]:not(.-x-evo-plaintext-quoted) blockquote[type=cite]:not(.-x-evo-plaintext-quoted) blockquote[type=cite]:not(.-x-evo-plaintext-quoted) {
  border-color: rgb(233,185,110);
}
</style></head><body data-message="" data-converted="" spellcheck="true" style="font-family: monospace; word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" bgcolor="#ffffff" text="#555555" link="#569be4" vlink="#569be4" data-evo-draft=""><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; ">On Mon, 2016-02-08 at 22:27 +0000, Luis Henriques wrote:</div><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; "><br></div><blockquote type="cite" id="-x-evo-main-cite" class="-x-evo-plaintext-quoted"><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; "><span class="-x-evo-quoted"><span class="-x-evo-quote-character">&gt; </span></span>Luis Henriques (4):</div><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; "><span class="-x-evo-quoted"><span class="-x-evo-quote-character">&gt; </span></span>&nbsp; powerpc/ps3: gelic_udbg: use struct ethhdr from &lt;linux/if_ether.h&gt;</div><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; "><span class="-x-evo-quoted"><span class="-x-evo-quote-character">&gt; </span></span>&nbsp; powerpc/ps3: gelic_udbg: use struct vlan_hdr from &lt;linux/if_vlan.h&gt;</div><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; "><span class="-x-evo-quoted"><span class="-x-evo-quote-character">&gt; </span></span>&nbsp; powerpc/ps3: gelic_udbg: use struct iphdr from &lt;linux/ip.h&gt;</div><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; "><span class="-x-evo-quoted"><span class="-x-evo-quote-character">&gt; </span></span>&nbsp; powerpc/ps3: gelic_udbg: use struct udphdr from &lt;linux/udp.h&gt;</div></blockquote><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; "><br></div><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; ">These all look fine. &nbsp;Thanks for taking time to do this clean up. &nbsp;I'll try to test next chance I get.</div><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; "><br></div><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; ">Acked-by: Geoff Levand &lt;<a href="mailto:geoff@infradead.org">geoff@infradead.org</a>&gt;</div><div class="-x-evo-paragraph" style="width: 71ch; word-wrap: normal; "><span id="-x-evo-selection-start-marker" data-anchor=""></span><span id="-x-evo-selection-end-marker"></span><br></div></body></html>
