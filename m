From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Conrad H Ziesler <cziesler@umich.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ibook, hda power off sequence (for IBM travelstar) 
Date: Mon, 8 Jan 2001 12:26:25 +0100
Message-Id: <19341203045809.13248@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.SOL.4.10.10101061727190.28634-100000@frogger.gpcc.itd.umich.edu>
References: 
 <Pine.SOL.4.10.10101061727190.28634-100000@frogger.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>This bit of code replaces pmu_shutdown from via-pmu.c, its the easiest
>hack to get the IDE code to issue a sleep command to the disk at shutdown
>time.

Broadcasting fake sleep requests is definitely not the correct way to
acheive what you want. Either add direct call to some ide-pmac sleep
function in the arch shutdown function, or use the shutdown notifiers in
ide-pmac to force a disk shutdown.

I'll have a look at it when I'm really back.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
