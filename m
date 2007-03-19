Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <45FEA390.7070703@am.sony.com>
Date: Mon, 19 Mar 2007 07:52:00 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org
Subject: Re: ps3-kexec.git
References: <45FC75A7.1090307@am.sony.com>
In-Reply-To: <45FC75A7.1090307@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> Just FYI, I made a git repo for my kexec-tools work here:
> 
>   git://git.kernel.org:/pub/scm/linux/kernel/git/geoff/ps3-kexec.git
> 
> I need to make kexec-tools support loading of a powerpc zImage.  For PS3
> I have the file temporarily named zImage.ps3.wrap, built with the make
> target 'zImage'.
> 
> It looks like someone has already done some work towards supporting
> zImage loads, but there is a note that indicates it is not yet working.

I decided to renamed ps3-kexec.git to ps3-kexec-tools.git to avoid any confusion.
Use something like this to re-clone:

mv ps3-kexec.git ps3-kexec-tools.git.old
git clone --reference ps3-kexec-tools.git.old git://git.kernel.org:/pub/scm/linux/kernel/git/geoff/ps3-kexec-tools.git

Sorry for any inconvenience.

-Geoff
