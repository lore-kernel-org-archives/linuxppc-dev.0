Date: Fri, 27 Feb 2004 17:32:03 +0100 (CET)
From: Marius Groeger <mgroeger@sysgo.com>
To: Bob Beck <beck@assurtech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ADS860 - unable to load kernel- Bad magic number
In-Reply-To: <1077816291.4242.6.camel@budweiser>
Message-ID: <Pine.LNX.4.56.0402271730001.24044@mag.sysgo.com>
References: <Iq959772845498.03218@webmail1.inner-21cn.com>
 <1077816291.4242.6.camel@budweiser>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 27 Feb 2004, Bob Beck wrote:

>  What is the difference between vmlinux and zImage.embedded ?

vmlinux is the plain kernel ELF image. You can use it to analyse the kernel
code or symbols, but you cannot boot it as-is.

zImage.embedded is the compressed kernel image plus some glue code used as a
bridge between the firmware and the kernel.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>
Project Manager

SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
Am Pfaffenstein 14
55270 Klein-Winternheim, Germany

Voice: +49-6136-9948-0 | FAX: +49-6136-9948-10
www.sysgo.com | www.elinos.com | www.osek.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
