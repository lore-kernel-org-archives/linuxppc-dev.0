Message-ID: <3FB7FE13.9060500@jonmasters.org>
Date: Sun, 16 Nov 2003 22:45:39 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Alan Modra <amodra@bigpond.net.au>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel oops due to unaligned access with lswi
References: <20031115210449.GA10105@suse.de> <20031115222430.GA13820@suse.de> <200311152230.hAFMUwT32990@makai.watson.ibm.com> <20031115224342.GA16897@suse.de> <200311152259.hAFMxGT27464@makai.watson.ibm.com> <1068977831.681.8.camel@gaston> <3C0F7C71-185D-11D8-976A-000393DBC2E8@motorola.com> <20031116221932.GD14287@bubble.sa.bigpond.net.au>
In-Reply-To: <20031116221932.GD14287@bubble.sa.bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Alan Modra wrote:

| On Sun, Nov 16, 2003 at 11:49:32AM -0600, Kumar Gala wrote:
|
|>If Ben's comments are correct simply removing -mstring as an option
|>passed to the build should get the desired behavior.
|
|
| Yes.  I can't see any problem with gcc's behaviour here, and I'm
| surprised that some processor is taking alignment exceptions on lswi.

The 601 reputedly broke a number of the PowerPC specifications however
so I am not surprised if it has this problem - the trouble is you can
fix up the alignment exception handler in Linux but not the firmware
handlers being used prior to that. Anyway people suggested workarounds.

Jon.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
