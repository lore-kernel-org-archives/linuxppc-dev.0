Subject: Re: 2.4.x swim3 performance problem on PM4400 identified
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mikpe@csd.uu.se
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <16026.33208.382857.751115@gargle.gargle.HOWL>
References: <16004.27866.270601.561756@gargle.gargle.HOWL>
	 <16005.35950.570218.844672@nanango.paulus.ozlabs.org>
	 <16026.33208.382857.751115@gargle.gargle.HOWL>
Content-Type: text/plain
Message-Id: <1050314560.5575.68.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 14 Apr 2003 12:02:40 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-04-14 at 11:39, mikpe@csd.uu.se wrote:

> I finally got around to testing your updates to swim3.c. I haven't
> observed any problems with it, and it solved my slow-writes problem.
> Great work -- thanks.
>
> There are two compile warnings on unused variables 'swim3_buf' and
> 'max_wait_inactive' that your update introduces. Did you intend
> to use them or what?

I fixed those in the version I merged in my tree, Paul's updates to
swim3 are in 2.4.20-ben10.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
