Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D0797F8.4030100@eccincorp.com>
Date: Wed, 12 Jun 2002 14:50:32 -0400
From: Jon Baker <jon@eccincorp.com>
Reply-To: jon@eccincorp.com
MIME-Version: 1.0
To: Embedded Linux Forum <linuxppc-embedded@lists.linuxppc.org>
Subject: Interrupt Latency
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am curious about interrupt latency.

I have an Embedded Planet RPX Classic CLLF_BW31 MPC860 running at 48Mhz with
non-realtime Hard Hat 1.2 with the 2.2.14 kernel.

In general what kind of interrupt latency can I expect?  I am seeing a pretty
consistent 10 us min IRQ2 latency but occassionally see up to 70 us max.  I am
not using IRQ0 or IRQ1 (therefore IRQ2 is highest priority) and we monitored
this with my application code doing next to nothing.  Basically I am only
running ISR2.  First, I was surprised the 10 us min latency, I thought I might
occassionally see a much quicker response.  Second, I was surprised to see the
occassional slow response of 70 us max.  It would be nice if we could get the
max under 50 us.  Or do you have to go to a real-time kernel?  I am looking into
my code to see that I am not masking the interrupt for too long (or even at all)
and checking the driver code efficiency.  Could the non-realtime linux kernel
mask the interrupts for that long?  I am going to look into what all linux is
doing, I am thinking it is not doing much but have not verified this.  I tried
to find some general interrupt latency numbers on the web through Monta Vista or
others but did not find anything relevant.

Jon Baker

===================================
Jon Baker
Software Engineer
Efficient Channel Coding, Inc.
216-635-1610
www.eccincorp.com
===================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
