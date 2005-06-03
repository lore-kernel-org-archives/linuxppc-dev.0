Return-Path: <rsiemsen@rossvideo.com>
Received: from server06.rossvideo.com (gw-rossvideo.storm.ca [209.87.241.202])
	by ozlabs.org (Postfix) with ESMTP id 2867367B42
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 07:49:19 +1000 (EST)
Message-ID: <42A0CD87.9070703@rossvideo.com>
Date: Fri, 03 Jun 2005 17:37:11 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: peng gu <penggu@hotmail.com>
References: <BAY14-F221B4CA9C143B0241EEF01C1070@phx.gbl>
In-Reply-To: <BAY14-F221B4CA9C143B0241EEF01C1070@phx.gbl>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: RTnet broadcast
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

peng gu wrote:
> hello
>  I am a postgraduate.  I only want to use RT-net to generate UDP-packets 
> every 10 millisecond(broadcast).
> I had post my question to the RTnet mailing list to find someone to help 
> ,but no one answer me. may be it is too simple and funny to answer for 
> them,. but it is hard to me . If I use RTnet only for a packet generator 
> not for building real-time Ethernet , whether there are something 
> different from the socket programming to generate UDP packets on a 
> "normal" network? (for example ,a local network that have one switch, 
> and only one station broadcasting message to itself,) , If yes, Would 
> you kind to tell me, and to list the functions of RTnet and RTAI that I 
> must used to do this work. and tell me where I can find the similar 
> application would someone give me a hand.

Have you tried looking at the examples that come with RTnet?
http://www.rts.uni-hannover.de/rtnet/lxr/source/addons/examples
in particular the "raw-packets" example should show you how to do what
you want.

-R
