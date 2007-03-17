Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <45FC75A7.1090307@am.sony.com>
Date: Sat, 17 Mar 2007 16:11:35 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org
Subject: ps3-kexec.git
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just FYI, I made a git repo for my kexec-tools work here:

  git://git.kernel.org:/pub/scm/linux/kernel/git/geoff/ps3-kexec.git

I need to make kexec-tools support loading of a powerpc zImage.  For PS3
I have the file temporarily named zImage.ps3.wrap, built with the make
target 'zImage'.

It looks like someone has already done some work towards supporting
zImage loads, but there is a note that indicates it is not yet working.

-Geoff
