Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <A984ECC2-9094-4045-B49E-95D924E6AAD2@kernel.crashing.org>
References: <1204800155-11613-1-git-send-email-leoli@freescale.com>
	<20080307002730.GB24142@localhost.localdomain>
	<A984ECC2-9094-4045-B49E-95D924E6AAD2@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3e5545630948f7bb2a2a6e103eb4ed10@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Add local bus device nodes to MPC837xMDS device trees.
Date: Fri, 7 Mar 2008 19:24:10 +0100
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I've seen several variants for board control devices (cpld, bcsr,
>> fpga, etc.) I suggest we standardise on "board-control"
>
> I don't see any reason for this.  If I have a cpld or fpga why not
> just call it that.  I don't see what calling it 'board-control' gets
> us.  There may be non-board control functionality in an fpga than what
> do we call it?

Good point.  Also, it is important to keep in mind that the "name" is
meant for human consumption only, so while it is important to use some
consistent naming (to not confuse the user), there should be quite some
leeway here.


Segher
