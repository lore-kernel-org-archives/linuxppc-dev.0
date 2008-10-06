Return-Path: <sumedhtirodkar@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 93510DDDE1
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Oct 2008 23:52:03 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so1247493nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 06 Oct 2008 05:52:01 -0700 (PDT)
Message-ID: <d2b9ccd90810060552p2bc86822oeda38de02daacbd1@mail.gmail.com>
Date: Mon, 6 Oct 2008 18:22:01 +0530
From: "sumedh tirodkar" <sumedhtirodkar@gmail.com>
To: "Nicholas Mc Guire" <hofrat@hofr.at>
Subject: Re: SA-RTLinux for ppc?
In-Reply-To: <Pine.LNX.4.58.0810052136040.1778@vlab.hofr.at>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_50340_1967203.1223297521084"
References: <0B45E93C5FF65740AEAE690BF3848B7AD383BB@rennsmail04.eu.thmulti.com>
	<Pine.LNX.4.58.0810030958420.2907@vlab.hofr.at>
	<d2b9ccd90810052035s3c9ca659l3f71e4e228eb31b1@mail.gmail.com>
	<Pine.LNX.4.58.0810052136040.1778@vlab.hofr.at>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_50340_1967203.1223297521084
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Can you help me wid one more thing?
I m trying to find out what is the entry point for booting of
linux-powerpc..i.e. what is the file sequence that gets executed after
yaboot gives control to linux kernel?
there are no head.S nd setup.S files in arch/powerpc/boot/ directory...which
are present in arch/i386/boot

Regards,
Sumedh

On Mon, Oct 6, 2008 at 11:11 AM, Nicholas Mc Guire <hofrat@hofr.at> wrote:

>
> > I would definitely like to try out the early releases. how can u help me
> > with that?
> >
> We are cleaning it up a bit and packing it up as a fresh snapshot - the
> first snapshots can be found at:
>
>  ftp://dslab.lzu.edu.cn:/pub/xtratum/xtratum-ppc/snapshots
>
> The patch in the patches directory is agaist 2.6.19.2 from ELDK (not
> kernel.org) and was tested on 440EP/GR only.
>
> Dont expect this to be clean though ;)
>
> thx!
> hofrat
>

------=_Part_50340_1967203.1223297521084
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Can you help me wid one more thing?<br>I m trying to find out what is the entry point for booting of linux-powerpc..i.e. what is the file sequence that gets executed after yaboot gives control to linux kernel?<br>
there are no head.S nd setup.S files in arch/powerpc/boot/ directory...which are present in arch/i386/boot<br><br>Regards,<br>Sumedh<br><br><div class="gmail_quote">On Mon, Oct 6, 2008 at 11:11 AM, Nicholas Mc Guire <span dir="ltr">&lt;<a href="mailto:hofrat@hofr.at">hofrat@hofr.at</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d"><br>
&gt; I would definitely like to try out the early releases. how can u help me<br>
&gt; with that?<br>
&gt;<br>
</div>We are cleaning it up a bit and packing it up as a fresh snapshot - the<br>
first snapshots can be found at:<br>
<br>
&nbsp;ftp://dslab.lzu.edu.cn:/pub/xtratum/xtratum-ppc/snapshots<br>
<br>
The patch in the patches directory is agaist <a href="http://2.6.19.2" target="_blank">2.6.19.2</a> from ELDK (not<br>
<a href="http://kernel.org" target="_blank">kernel.org</a>) and was tested on 440EP/GR only.<br>
<br>
Dont expect this to be clean though ;)<br>
<br>
thx!<br>
hofrat<br>
</blockquote></div><br></div>

------=_Part_50340_1967203.1223297521084--
