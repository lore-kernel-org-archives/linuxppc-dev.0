Message-ID: <3C893DC4.6050806@cymes.de>
Date: Fri, 08 Mar 2002 23:40:04 +0100
From: Matthias Grimm <joker@cymes.de>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Cc: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: pbbuttons, need some help
References: <20020307134140.56d70400.jpgarcia@execpc.com> <20020308123301.27605@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote:

Hi,

> Note that OHare in /proc/pmu is still known to be flawky as it seems
> not all OHare based pbooks need the same formula. But at least it will
> be fixed one day and I prefer indeed keeping that tricky code in a
> single location. I do have some code to merge one of these days fixing
> calculation for the 2400 for example.


Yes, I am convinced. I will do it like Jeramy in gkrellm-pmud so I would
benefit from any of your future changes.


> Well, the daemon will still be needed to get the "special" keys on OHare
> based powerbooks as I think those don't come via ADB.


Good point. The PMU has two command regarding the volume and brightness
buttons. Do you have any information about this commands? I think they
are for machines that wouldn't send this keys via the keyboard as you
explained in one of our first emails. Would there be a chance to use
those commands to get the keys also on Powerbooks that don't support the
button device? That would extend the usability of pbbuttons on older
Powerbooks.

   Matthias


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
