Message-ID: <3FCB3969.9010707@catapult.com>
Date: Mon, 01 Dec 2003 07:51:53 -0500
From: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Peripherals  Memory Mapping
References: <Pine.GHP.4.58.0311271703390.25225@stud3.tuwien.ac.at>	 <7E0B03AE-2100-11D8-BF18-003065E2BB06@aimsys.nl>	 <Pine.GHP.4.58.0311271903490.4360@stud3.tuwien.ac.at>	 <1070011018.1263.27.camel@linpc003.aimsys.nl>	 <3FC76CEA.9040309@embeddededge.com> <1070266735.328.5.camel@linpc003.aimsys.nl>
In-Reply-To: <1070266735.328.5.camel@linpc003.aimsys.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Maybe this is a simple question, but I have searched the code
and played around with no luck.  This is for an 8260 FADS
board, later to be used on custom H/W.

How and where do I add peripherals memory to the memory
map?   I have tried adding it in the ads_map_io function but
when I try to access the 82xx internal memory space there to
add the memory to the base and option registers it dies.
io_block_mapping is called successfully for the internal
space, but appears to be inaccessable at this time.

Is there a function that adds memory ranges to both the Linux
map and the processor map (Base and Option registers) ?

Thank you
Kevin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
