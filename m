Return-Path: <slightlyunconventional@gmail.com>
Received: from mail-gx0-f14.google.com (mail-gx0-f14.google.com
	[209.85.217.14]) by ozlabs.org (Postfix) with ESMTP id 7E3DB474C3
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 02:19:33 +1100 (EST)
Received: by gxk7 with SMTP id 7so10540407gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 08:19:31 -0700 (PDT)
Message-ID: <fb412d760810220819o1a15d47ej198f6e15c3e63f15@mail.gmail.com>
Date: Wed, 22 Oct 2008 10:19:31 -0500
From: "Hollis Blanchard" <hollis@penguinppc.org>
Sender: slightlyunconventional@gmail.com
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: build failure on powerpc with current -git
In-Reply-To: <18686.42209.47915.184451@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_22050_946874.1224688771263"
References: <48F8E86B.702@nortel.com>
	<18685.27030.529655.761257@cargo.ozlabs.ibm.com>
	<20081021191324.d4810d40.sfr@canb.auug.org.au>
	<18686.42209.47915.184451@cargo.ozlabs.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_22050_946874.1224688771263
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Oct 21, 2008 at 10:58 PM, Paul Mackerras <paulus@samba.org> wrote:

> Stephen Rothwell writes:
>
> > On Tue, 21 Oct 2008 16:33:10 +1100 Paul Mackerras <paulus@samba.org>
> wrote:
> > >
> > > It's a bug in older versions of ld (including 2.16.1) that's fixed in
> > > the current version (2.18).  However, this patch appears to work
> > > around the problem - at least, it let me build a 32-bit kernel with a
> > > cross-toolchain including a 2.16.1 ld.  Let me know if this gets it
> > > working for you.
> >
> > With that patch applied I got these errors for a powerpc ppc64_defconfig
> > build (linux-next).
> >
> > /usr/bin/objcopy: Warning: '/dev/null' is not an ordinary file
>
> Hmmm, so do I, and in fact the arch/powerpc/boot/wrapper change now
> seems to be unnecessary with my cross-compile setup (which has ld
> 2.16.1), whereas yesterday I'm sure it got errors.  Weird.
>
> Chris, could you try just the following change (my previous patch
> without the arch/powerpc/boot/wrapper change) and let me know if it
> fixes things with the ld you use?
>

Works for me.

binutils 2.16.1 is the most recent binutils that will build with crosstool,
so IMHO it's worth supporting. :)

-Hollis

------=_Part_22050_946874.1224688771263
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">On Tue, Oct 21, 2008 at 10:58 PM, Paul Mackerras <span dir="ltr">&lt;<a href="mailto:paulus@samba.org">paulus@samba.org</a>&gt;</span> wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Stephen Rothwell writes:<br>
<br>
&gt; On Tue, 21 Oct 2008 16:33:10 +1100 Paul Mackerras &lt;<a href="mailto:paulus@samba.org">paulus@samba.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; It&#39;s a bug in older versions of ld (including 2.16.1) that&#39;s fixed in<br>
&gt; &gt; the current version (2.18). &nbsp;However, this patch appears to work<br>
&gt; &gt; around the problem - at least, it let me build a 32-bit kernel with a<br>
&gt; &gt; cross-toolchain including a 2.16.1 ld. &nbsp;Let me know if this gets it<br>
&gt; &gt; working for you.<br>
&gt;<br>
&gt; With that patch applied I got these errors for a powerpc ppc64_defconfig<br>
&gt; build (linux-next).<br>
&gt;<br>
&gt; /usr/bin/objcopy: Warning: &#39;/dev/null&#39; is not an ordinary file<br>
<br>
</div>Hmmm, so do I, and in fact the arch/powerpc/boot/wrapper change now<br>
seems to be unnecessary with my cross-compile setup (which has ld<br>
2.16.1), whereas yesterday I&#39;m sure it got errors. &nbsp;Weird.<br>
<br>
Chris, could you try just the following change (my previous patch<br>
without the arch/powerpc/boot/wrapper change) and let me know if it<br>
fixes things with the ld you use?<br>
</blockquote><div><br>Works for me.<br><br>binutils 2.16.1 is the most recent binutils that will build with crosstool, so IMHO it&#39;s worth supporting. :)<br><br>-Hollis <br></div></div></div>

------=_Part_22050_946874.1224688771263--
