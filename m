Return-Path: <mlan@cpu.lu>
Date: Sat, 21 Jan 2006 21:52:03 +0100 (CET)
From: Mich Lanners <mlan@cpu.lu>
Sender: Mich Lanners <mlan@cpu.lu>
Subject: HD light: stuck illuminated
To: Linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Message-Id: <E1F0PiO-0000SL-00@piglet.grunz.lu>
Reply-To: Mich Lanners <mlan@cpu.lu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I just had a quirk with the HD light feature in kernel 2.6.15 (straight
kernel.org).

When killing a process that caused heavy disk access, the light got
stuck illuminated with no activity, and behaved inverted from then on:
always on, except when the disk is active...

A bit later, the problem corrected itself, but I don't know why
specifically.

So there might be a problem with the state logic there. I have not had
time to look at the source...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "
