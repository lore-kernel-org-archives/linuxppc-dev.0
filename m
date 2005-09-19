Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <17197.65270.548340.377011@cargo.ozlabs.ibm.com>
References: <17197.65270.548340.377011@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F73AC15B-DE4B-439A-ACAF-F0DD34B6A047@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 19 Sep 2005 09:29:50 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Git tree for the 32/64 merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sep 18, 2005, at 6:57 PM, Paul Mackerras wrote:

> I have created a git tree on kernel.org as a place to accumulate the
> patches for the ppc32/ppc64 merge.  It is at:
>
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc- 
> merge.g
> it
>
> It doesn't include the objects in Linus' tree; instead it has an
> objects/info/alternates file pointing to Linus' tree.
>
> This tree contains all the patches I found in a scan through my inbox
> that relate to the merge and haven't already gone to Linus.  If you
> have a patch that should go in, please resend it.

Paul,

You pulled the wrong version of the Kconfig patch for prep/chrp/ 
pmac.  There is a newer version that doesn't leave duplicated 'bool's  
in the Kconfig:

http://patchwork.ozlabs.org/linuxppc/patch?id=2447

- kumar
