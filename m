Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.203])
	by ozlabs.org (Postfix) with ESMTP id E04B267A71
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 14:45:44 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 57so825038wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Feb 2005 19:45:39 -0800 (PST)
Message-ID: <528646bc050228194513f04673@mail.gmail.com>
Date: Mon, 28 Feb 2005 20:45:38 -0700
From: Grant Likely <glikely@gmail.com>
To: Stephen Warren <SWarren@nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B004F06D6C@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <DBFABB80F7FD3143A911F9E6CFD477B004F06D6C@hqemmail02.nvidia.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: NPTL on MPC5200
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 28 Feb 2005 16:30:14 -0800, Stephen Warren <SWarren@nvidia.com> wrote:
> Does anybody know of any distros (commercial or otherwise) that support
> the MPC5200 as a target and some any/all of:
> 
> NPTL (Native Posix Threading Library)
> ALSA
I've brought up Gentoo on my MPC5200 eval board (NFS root).  It
supports ALSA and I'm pretty sure NPTL also.  I'm simply cutting back
the files in the rootfs to fit onto my ultimate target.

I'm using Sylvain Munaut's 2.6 port to the eval board. 
http://246tnt.com/mpc52xx/

g.
