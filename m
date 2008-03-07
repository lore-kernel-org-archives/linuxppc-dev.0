Return-Path: <galak@kernel.crashing.org>
Message-Id: <A984ECC2-9094-4045-B49E-95D924E6AAD2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080307002730.GB24142@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/2] Add local bus device nodes to MPC837xMDS device trees.
Date: Fri, 7 Mar 2008 08:35:39 -0600
References: <1204800155-11613-1-git-send-email-leoli@freescale.com>
	<20080307002730.GB24142@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 6, 2008, at 6:27 PM, David Gibson wrote:

> [snip]
>> +		bcsr@1,0 {
>> +			reg = <1 0x0 0x8000>;
>> +			compatible = "fsl,mpc837xmds-bcsr";
>> +		};
>> +
>> +		nand@3,0 {
>
> This isn't a problem with this device tree, but it's probably time we
> started establishing some conventional generic names for nand flash
> and board-control devices.
>
> So, to start the ball rolling, I've seen several names for nand flash
> nodes, I'd suggest we standardise on "nand-flash".

This seems reasonable.

> I've seen several variants for board control devices (cpld, bcsr,
> fpga, etc.) I suggest we standardise on "board-control"

I don't see any reason for this.  If I have a cpld or fpga why not  
just call it that.  I don't see what calling it 'board-control' gets  
us.  There may be non-board control functionality in an fpga than what  
do we call it?

- k
