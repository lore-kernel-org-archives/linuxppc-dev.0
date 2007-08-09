Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound6-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4775DDDED7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 04:46:59 +1000 (EST)
Date: Thu, 09 Aug 2007 11:46:50 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: khollan <khollan@daktronics.com>
Subject: Re: BusyBox Mount
References: <12077740.post@talk.nabble.com>
In-Reply-To: <12077740.post@talk.nabble.com>
Content-Type: text/plain; charset=us-ascii
Message-Id: <20070809184653.DA59498807D@mail58-cpk.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Khollan,

try to use:

  mount -t vfat -ouid=uuu,gid=ggg /dev/xsa1 /home/Dak

where uuu is the User ID of your user and ggg is its Group ID.

Cheers,
   Wolfgang




khollan wrote:
> Hi
> 
> I want to mount the first partion of my compact flash in a users home folder
> during bootup.  This partion should be owned by the user and be read write
> and executable.  I am using the command:
> mount -t vfat /dev/xsa1 /home/Dak
> in the rcS startup script.  This works fine but it is owned by the root, if
> I try to change the ownership with chown as root it says that Operation not
> permitted, if I Chmod to 777 it appears to take but when you ls -l it out it
> says that it is onlt rw by the owner root.
> Any suggestions
> khollan
