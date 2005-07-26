Return-Path: <kumar.gala@freescale.com>
Mime-Version: 1.0 (Apple Message framework v733)
Message-Id: <CF36C2B8-267D-421C-AA4E-7AE83DCF5172@freescale.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 25 Jul 2005 23:18:12 -0500
Subject: platform/board removal update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

I'm going to be sending a series of patches to remove the following  
board/platforms (as discussed earlier):

adir
ash
beech
cedar
ep405
k2
mcpn765
menf1
oak
pcore
rainier
redwood
sm850
spd823ts

The following board/platforms are currently not building:
apus
gemini
lite5200
prpmc750
radstone_ppc7d
rpxcllf
TQM8260

At OLS, Paul and the various sub-arch maintainers (in attendance)  
discussed that if the set of board/platforms that are not building  
are not fixed by the release of 2.6.15 we will be removing support  
for them.  Some of the build issues are trivial and I may look at  
fixing them myself.  For all of the systems that I dont fix I'll be  
sending a patch marking them BROKEN in the Kconfig file.  If these  
systems are still BROKEN after 2.6.15 we will be removing them.

- kumar
