Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3EE8A746.7010901@mvista.com>
Date: Thu, 12 Jun 2003 11:16:06 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Running Linux with 2Mo of Ram.
References: <D96E2AFA0DF3D211B139009027454948037362FE@helios.gnv.tcc.thomson-csf.com>
In-Reply-To: <D96E2AFA0DF3D211B139009027454948037362FE@helios.gnv.tcc.thomson-csf.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Christophe.LINDHEIMER@fr.thalesgroup.com wrote:
> Hi.
>
> I am trying to run linux on a custom board ( Mpc8xx )
> There is only 2Mo of RAM.
> I use romfs to save RAM.
>
> I use U-boot to start the kernel.
>
> The kernel starts correctly.
> the kernel is launched with init=/bin/sh
>
> The kernel stops to tell me to press enter to activate the console ( to
> launch the sh ) and then crash because it is running out of memory.
>
> The question is to know if it is really impossible to make Linux work on
> this target or is I have missed something that could explain that there is
> no more memory available.

You will need some type of "execute in place", i.e. run the kernel and/or
userspace applications out of ROM in order to work with 2MB of RAM.

This type of thing is generally very board, processor and application specific.
  So I don't believe there is existing (open source) code to do it.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
