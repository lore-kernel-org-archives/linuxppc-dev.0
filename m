From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Hankin <shankin@rational.com>,
	Linux PPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.5-pre1 hangs on Wallstreet
Date: Sat, 5 May 2001 02:05:56 +0200
Message-Id: <20010505000556.26820@mailhost.mipsys.com>
In-Reply-To: <200105032145.QAA05255@lists.linuxppc.org>
References: <200105032145.QAA05255@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I built the latest bk tree this morning after rsyncing, and on boot, I
>> only get the initial black screen, then it stops.  No dump, no monitor,
>> no nothing.  Where do I go from here?
>
>An update:  it hangs after printing out the "MMU: exit" message.  On my
>2.4.4 kernel, it goes on to tell me "xmon uses screen and keyboard" on
>the next line, but on 2.4.5-pre1, it just stops.

BootX/miBoot booting was broken lately.

I added a workaround to my rsync tree, I'll try to come up with a
better solution for bk this week-end.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
