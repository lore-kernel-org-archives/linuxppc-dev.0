Date: Wed, 12 May 1999 11:21:07 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Jason Haas <jhaas@madison-web.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: New PPC/Mac features of 2.2.8?
In-Reply-To: <37399524.9D22A030@madison-web.com>
Message-ID: <Pine.LNX.3.96.990512111219.4922A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 May 1999, Jason Haas wrote:

> Hi folks,
> 
> The cutting-edge linux site says there are "major PPC arch" updates and
> mac arch updates in 2.2.8.  What are they?  Or, is there somewhere I can
> look to find out?

Well, one thing I've noted is that a good deal of the Motorola support has
made its way out of Mot, through cvs, and into 2.2.8/2.3.0.  This includes
proper ID of every board, configuration of the MPIC, and proper PCI
interrupt routing based on the board type.  A major step forward for Mot
PReP systems.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
