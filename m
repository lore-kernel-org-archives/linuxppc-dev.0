Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 3 Jun 2003 21:28:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Failsafe bootloader
Message-ID: <20030603192851.GA1921@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all.

We are developing an application for an embedded target that will be
located in some rural areas. We foresee a need to update the target
with a new version of the application or a new kernel from time to time.

A few of the added requirements on top of that are:
1) The target shall boot up in the old kernel, if a bogus kernel is loaded
2) The target shall boot up in the old application, if a bogus
	application is loaded
3) On the management side an update shall be handled as a single file,
	the target may decide to 'unpack' it when received.

We have looked all over the net, but none of the bootloaders found
so far could meet the above demands.
The boot loaders usually have an interactive mode used to select
between different configurations - and there are no feedback from
the application side if the reboot actually went well.
The interactiviness does not fit well with an embedded target.

Do you know of a boot loader that partially or fully meets the above
requirements?

Background information
Today we are using VxWorks - for which we have made our own boot loader.
The boot laoder allows the boot loader itself, and the application part
to be upgraded - and if a restart is failed the old version will
be activated on a subsequent build.
I want the same behaviour in the Linux based target.

	Thanks in advance,

	Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
