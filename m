Return-Path: <ganeshkumar@signal-networks.com>
Message-ID: <001901c5bcd3$4e181690$0d01a8c0@signet>
From: "ganeshkumar" <ganeshkumar@signal-networks.com>
To: <Linuxppc-dev@ozlabs.org>
Date: Mon, 19 Sep 2005 10:03:38 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: System RAM requirement for PBX - Router Application product
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear All,

    I'm working on MPC860P with 8MB of FLash ROM and 16MB of RAM
on our system running Mvista Linux. Our Product is an Integrated Access
Device
with the following features built in:
        1)    ISDN PRI on E1 interface with 15 channels for Voice & 15
                Channels for Data
        2)    LAN to WAN Router and vice versa, serving Internet users on
the LAN side.
        3)    Built in PABx functionality serving upto 60 extensions
        4)    Embedded mySQL database for Call details and Records,
        5)    An IDE interface supporting a 80GB HDD
        6)    Web server for configuration (Boa)

So for a product with the above configuration/features , what is the minimum
amount memory that is needed to run without any flaws?
Currently we have 8MB Flash, 16MB SD-RAM with MPC860P running @ 40MHz
Is 16MB SD-RAM enough for this type of an Application? or we need to
increase our SD-RAM size?
Thanks in Advance!

Thanks & Best regards,
Ganesh
