Message-ID: <3D13359C.2030803@motorola.com>
Date: Fri, 21 Jun 2002 15:18:04 +0100
From: John Traill <john.traill@motorola.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	Dan Malek <dan@embeddededge.com>, Wolfgang Denk <wd@denx.de>,
	Tom Rini <trini@kernel.crashing.org>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
References: <20020619221532.F3C7A10301@denx.denx.de>	<3D120573.4000305@embeddededge.com>	<3D12F140.23BA447F@imc-berlin.de> <15635.12386.415897.593660@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Everyone/Anyone,

Does this mean linuxppc_2_4_devel will disappear leaving a 2.4 stable tree and a 2.5 devel ?


Paul Mackerras wrote:
> Steven Scholz writes:
>
>
>>I am not quite sure about the policies now. Could you please explain:
>>
>>linuxppc_2_4		is a stable tree
>>linuxppc_2_4_devel	is a devel tree
>>linuxppc_2_5		is a devel tree
>>
>>Is that right?
>
>
> 2_4_devel is stabilizing.  Once 2.4.19 comes out the plan is to
> restructure the linuxppc_2_4 tree along the lines of the 2_4_devel
> tree and start moving the stuff from 2_4_devel into 2_4 and submit it
> to Marcelo.
>
> With 2.5, I am hoping to be able to keep Linus' tree in closer sync
> with our linuxppc-2.5 tree than we managed in the past with the 2_4
> trees.
>
> Paul.
>


--

Regards, John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
