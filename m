Message-ID: <3CD82EA0.2040308@embeddededge.com>
Date: Tue, 07 May 2002 15:44:32 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Pete Flugstad <pete_flugstad@icon-labs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problem compiling linuxppc_2_4_devel for MBX
References: <3CD82C4B.60606@icon-labs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pete Flugstad wrote:


>   make menuconfig -- update to taste/needs

It appears you included PCI and other things which haven't worked
in ages.  The MBX will work as an 860 processor, and only with
the internal peripherals.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
