Return-Path: <muvarov@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 3BD32DDE08
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 17:28:43 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1924644fga.39
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 23:28:41 -0700 (PDT)
Message-ID: <572af9170810142328j7596290bv8e6c89df1e31dd48@mail.gmail.com>
Date: Wed, 15 Oct 2008 10:28:41 +0400
From: "Maxim Uvarov" <muvarov@gmail.com>
To: "Simon Horman" <horms@verge.net.au>
Subject: Re: [PATCH] kexec memory ranges dynamic allocation
In-Reply-To: <20081015031818.GC27243@verge.net.au>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7357_391147.1224052121883"
References: <572af9170810140811v446a6874pd67cb77753a9e32d@mail.gmail.com>
	<20081015031818.GC27243@verge.net.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_7357_391147.1224052121883
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/10/15 Simon Horman <horms@verge.net.au>

> On Tue, Oct 14, 2008 at 07:11:19PM +0400, Maxim Uvarov wrote:
> > Hello all,
> >
> > As you all know it is not easy to count exact value of memory ranges from
> > device tree on powerpc.
> > It very depends on how dts file was written. What do you think about
> really
> > dynamic allocation buffers
> > for this buffers?
>
> Conceptually I have no objections to the change,
> though I would like to get some review from ppc people.
> (linuxppc-dev@ozlabs.org CCed)
>
> > Patch is attached.
>
> This patch doesn't seem to compile for me.
>
> # powerpc64-unknown-linux-gnu-gcc --version
> powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.1
> Copyright (C) 2006 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> #make
> [snip]
> kexec/arch/ppc64/kexec-ppc64.c:100: warning: function declaration isn't a
> prototype
> kexec/arch/ppc64/kexec-ppc64.c: In function 'realloc_memory_ranges':
> kexec/arch/ppc64/kexec-ppc64.c:107: warning: passing argument 1 of
> 'realloc' makes pointer from integer without a cast
> kexec/arch/ppc64/kexec-ppc64.c:107: error: too few arguments to function
> 'realloc'
> kexec/arch/ppc64/kexec-ppc64.c:102: warning: unused variable 'tmp'
>
Sorry  I edited manually formated patch before sending and lost first
argument to realloc. I will resend it.

>
> --
> Simon Horman
>  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
>  H: www.vergenet.net/~horms/ <http://www.vergenet.net/%7Ehorms/>
>   W: www.valinux.co.jp/en
>
>


-- 
Best regards,
Maxim Uvarov

------=_Part_7357_391147.1224052121883
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">2008/10/15 Simon Horman <span dir="ltr">&lt;<a href="mailto:horms@verge.net.au">horms@verge.net.au</a>&gt;</span><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Tue, Oct 14, 2008 at 07:11:19PM +0400, Maxim Uvarov wrote:<br>
&gt; Hello all,<br>
&gt;<br>
&gt; As you all know it is not easy to count exact value of memory ranges from<br>
&gt; device tree on powerpc.<br>
&gt; It very depends on how dts file was written. What do you think about really<br>
&gt; dynamic allocation buffers<br>
&gt; for this buffers?<br>
<br>
</div>Conceptually I have no objections to the change,<br>
though I would like to get some review from ppc people.<br>
(<a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a> CCed)<br>
<br>
&gt; Patch is attached.<br>
<br>
This patch doesn&#39;t seem to compile for me.<br>
<br>
# powerpc64-unknown-linux-gnu-gcc --version<br>
powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.1<br>
Copyright (C) 2006 Free Software Foundation, Inc.<br>
This is free software; see the source for copying conditions. &nbsp;There is NO<br>
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.<br>
<br>
#make<br>
[snip]<br>
kexec/arch/ppc64/kexec-ppc64.c:100: warning: function declaration isn&#39;t a<br>
prototype<br>
kexec/arch/ppc64/kexec-ppc64.c: In function &#39;realloc_memory_ranges&#39;:<br>
kexec/arch/ppc64/kexec-ppc64.c:107: warning: passing argument 1 of &#39;realloc&#39; makes pointer from integer without a cast<br>
kexec/arch/ppc64/kexec-ppc64.c:107: error: too few arguments to function &#39;realloc&#39;<br>
kexec/arch/ppc64/kexec-ppc64.c:102: warning: unused variable &#39;tmp&#39;<br>
<font color="#888888"></font></blockquote><div>Sorry&nbsp; I edited manually formated patch before sending and lost first argument to realloc. I will resend it. <br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<font color="#888888"><br>
--<br>
Simon Horman<br>
 &nbsp;VA Linux Systems Japan K.K., Sydney, Australia Satellite Office<br>
 &nbsp;H: <a href="http://www.vergenet.net/%7Ehorms/" target="_blank">www.vergenet.net/~horms/</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; W: <a href="http://www.valinux.co.jp/en" target="_blank">www.valinux.co.jp/en</a><br>
<br>
</font></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Maxim Uvarov<br>

------=_Part_7357_391147.1224052121883--
