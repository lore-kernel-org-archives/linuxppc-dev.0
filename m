Return-Path: <markos@codex.gr>
Received: from lvps87-230-20-158.dedicated.hosteurope.de
	(lvps87-230-20-158.dedicated.hosteurope.de [87.230.20.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 963ECB7B86
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Sep 2009 21:44:16 +1000 (EST)
Message-Id: <0046254A-432D-4AE3-9B9F-C0D30311B7D7@codex.gr>
From: Konstantinos Margaritis <markos@codex.gr>
To: linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org,
	opensuse-ppc@opensuse.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Market research for new PowerPC system
Date: Sat, 26 Sep 2009 14:38:38 +0300
Cc: Konstantinos Margaritis <markos@codex.gr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Sorry for the cross-posting, please ignore if you are not interested  
in this, CC me as I'm not subscribed)
Hi,

First some introductions. I'm Konstantinos Margaritis, a long time  
Amiga/BeOS/Linux user/developer and a PowerPC fan, former Debian  
Developer, also a SIMD/AltiVec fanatic and the author of libfreevec.  
I've posted this on the following sites:

http://amigaworld.net/modules/newbb/viewtopic.php?mode=viewtopic&topic_id=29594&forum=33&start=0&viewmode=flat&order=0

http://www.amiga.org/forums/showthread.php?t=49424

http://www.morphzone.org/modules/newbb_plus/viewtopic.php?topic_id=6465&forum=11

http://aros-exec.org/modules/newbb/viewtopic.php?viewmode=flat&topic_id=3768&forum=4

http://www.haiku-os.org/community/forum/market_research_new_powerpc_system#comment-12604

To anyone who is not a PowerPC user, it might seem like crazy, but  
here it goes:

I'm considering funding the design & production of a new PowerPC  
system (well, the motherboard, the rest are typical pc stuff and a  
case). No this is not a joke, I've been wanting to do this for a long  
time, and perhaps the chance will be given to me now. But before I  
spend any money on this, I want to do a little market research first.  
I know the market is literally "dying" for a new powerpc motherboard,  
but exactly how many are there that want to buy one?

Ok, let's give some rough specs first. I'm considering 3 choices -not  
in order of probability/importance:

1. MPC8640D-based. It will be dual core at 1Ghz -most likely, higher  
frequencies are much more expensive and the cost of the final board  
would be prohibitive.
2. MPC8610-based. Single core at 1Ghz, slightly less expensive, and  
includes a 2D DIU display unit -quite fast, but no 3D unfortunately.
3. QorIQ P1022-based. Again dual core at 1Ghz (1055Mhz to be precise).  
Apart from the much lower chip price, this one includes dual gigabit  
ethernet, dual SATA, USB 2.0 and a 2D DIU display unit (same as the  
MPC8610). So this one would lower the cost of the board quite much.  
Disadvantages: No AltiVec unit (it sucks I know), though it includes  
an SPE unit which is not that bad, and availability will be in Q3/Q4  
2010, so that's a long wait.

Now, the end motherboard will probably be MicroATX (in the 8640D/8610  
case) or PicoITX (in the P1022 case), and it will definitely include:

* SATA connectors
* USB (possibly 2 back and 2 front, but that's discussable)
* Dual gigabit (at least one will be there, in the case of the  
MPC8640D we might even have 4!!!)
* Sound (of course, SPDIF support will definitely be there)
* 1 PCI-e slot 1x
* 1 PCI-e slot (4x in the P1022 case, 8x in the MPC86xx cases)

Ok, what I want to know is if people would really really buy one of  
these. End price is estimated to be ~around~ 350EUR for the P1022  
board or ~500EUR (definitely more in the case of 8640D) in the case of  
the other boards. Besides being more expensive, the MPC86xx chips,  
don't include SATA, USB and only one of ethernet/sound (quad-gige in  
MPC8640D case, or sound in the case of MPC8610). I know this sounds a  
lot, but it's the reality, there is not enough funding to build  
enormous amounts of units and bring the prices down substantially, we  
have to start low and build up from there. In case you are wondering,  
yes, the boards will be designed/produced by bPlan and funded by my  
company (Codex).

Support for OSes: Linux definitely, Haiku most probably and there is a  
possibility of supporting AmigaOS/MorphOS, which will depend on the  
actual feedback I get from those users.

I would like to make a list of everyone that is really interested in  
such a system, so it would really help me make a decision sooner  
rather than later if you would send me a few personal details to markos@codex.gr 
  with subject "PowerPC board":

* Name
* Country
* email (definitely, I'd have to reach you back!)
* Phone/Skype (optional, please include international prefix)
* Forum you saw this post (ok, Morphzone in this case)
* OS of preference
* board you would be most interested in (MPC8610/MPC8640D/P1022)
* preferred price (please have in mind the estimated price quotes I  
mentioned, it might be lower but that's not very probable)
* Other notes/comments

Also, I found out that I had to state my case on many forums to prove  
that this is not vapourware. Well, it will not be vapourware, if I get  
feedback. So far the feedback I got can be summarized here:

http://www.codex.gr/index.php?pageID=&blogItem=60

Thanks a lot for your time and I hope this system becomes a reality.

Konstantinos Margaritis

Codex
