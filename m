Message-ID: <005701c27681$1615ee70$fc00a8c0@ycigrnd.ycig.com>
From: "leeyang" <leeyang@ycig.com>
To: "Tom Rini" <trini@kernel.crashing.org>,
	"Alex Zeffertt" <ajz@cambridgebroadband.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <000901c27583$b24224c0$fc00a8c0@ycigrnd.ycig.com> <Pine.LNX.4.44.0210171651120.2469-201000@localhost.localdomain> <20021017161329.GK695@opus.bloom.county>
Subject: Re: 860 rtc problem(sloved!!)
Date: Fri, 18 Oct 2002 16:33:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for all your replys and it had been sloved!

Very shy to say that I type wrong shell command with hwclock.
I used 'hwclock -s --date 'Oct 19 2002' 'before and it is wrong,
I miss an equation mark!!!
It should be 'hwclock -s --date='Oct 19 2002'.
without that mark hwclock think nothing to write and do nothing
so did not really write rtc.

Thx again to your kind fellows:-)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
