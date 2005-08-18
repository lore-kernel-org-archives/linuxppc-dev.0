Return-Path: <glikely@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.196])
	by ozlabs.org (Postfix) with ESMTP id A7F8C67F94
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2005 01:40:52 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 12so290585nzp
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2005 08:40:51 -0700 (PDT)
Date: Thu, 18 Aug 2005 09:31:02 -0600
To: somshekar chandrashekar kadam <som_kadam1@rediffmail.com>,
	linuxppc-dev@ozlabs.org
Message-ID: <20050818153102.GA21401@siegfried.thelikelysolution.ca>
References: <20050818065554.28998.qmail@webmail30.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050818065554.28998.qmail@webmail30.rediffmail.com>
From: Grant Likely <glikely@gmail.com>
Subject: Re: linuxppc cross compiler
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 18, 2005 at 06:55:54AM -0000, somshekar chandrashekar kadam wrote:
>  HI ,
> 
> need to set the cross compiler for Linux 2.6 PPC from scratch on X86 host  , is there any howto or anyother document , i saw only denx eldk supporting it . wanted to build entire cross compiler from scratch , please direct me to any good link if it is there , tried to open the link given on Embedded PowerPC linux howto , that page doesnt exist anymore ,please suggest guys which one is better  

I second te recommendation for crosstool.  You COULD unpack and build
binutils/gcc/glibc step by step, but you really don't want to unless you
enjoy beating you head against the wall.

http://www.kegel.com/crosstool

Also, subscribe to the crossgcc mailing list:
http://sources.redhat.com/ml/crossgcc/

Cheers,
g.
