Return-Path: <dwilson@dslextreme.com>
Received: from mail9.dslextreme.com (mail9.dslextreme.com [66.51.199.94])
	by ozlabs.org (Postfix) with SMTP id 40202DDE33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 13:22:48 +1100 (EST)
Message-ID: <200701171822470347.16A8224A@smtp.dslextreme.com>
In-Reply-To: <45ADD61A.7020005@dlasys.net>
References: <200701162102050578.1213ACC0@smtp.dslextreme.com>
	<45ADD61A.7020005@dlasys.net>
Date: Wed, 17 Jan 2007 18:22:47 -0800
From: "Dan Wilson" <dwilson@dslextreme.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ram-disk root file system
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/17/2007 at 2:54 AM David H. Lynch Jr. wrote:

>           Before you attempt to exec init, you can add code to open
> anyfile that you want on the ramdisk. opening a file requires less
> things to be right than exec'ing and that may isolate your problem
> further. I beleive you can enable system call tracing and find out more
> about where things are going off the rails.
>           You can also write a trivial hello world - one that does not
> use any libraries and very little code, and see if you can exec that.
> 

Hello world executed, which proved that the initramfs was mounted=
 correctly.

I then rebuilt busybox as a static executable, and now it runs and I get an
ash prompt.  I've still got some problems, but at least I'm moving forward
again!

Thanks for the pointer - simplifying back a hello world program was the
right move...

Best regards,

Dan.
