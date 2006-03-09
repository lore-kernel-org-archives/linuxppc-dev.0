Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17423.31975.260830.61636@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 11:55:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Subject: Re: please pull powerpc-merge.git
In-Reply-To: <20060308080816.GA16866@suse.de>
References: <17422.16982.705624.256207@cargo.ozlabs.ibm.com>
	<20060308080816.GA16866@suse.de>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

>  On Wed, Mar 08, Paul Mackeras wrote:
> 
> >       powerpc: incorrect rmo_top handling in prom_init
> 
> I would leave this one out. It gives the false impression that ibook1
> works ok, while later it will likely eat your filesystem. Its not a
> regression in that sense because 2.6.15 was also broken and noone
> complained.

Ben H and I agree that the fix makes sense and is correct and should
go in for 2.6.16.  Your iBook crashes are a separate problem.

Paul.
