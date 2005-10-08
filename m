Return-Path: <rmcguire@uwbt.com>
Received: from mail19d.g19.rapidsite.net (mail19d.dulles19-verio.com
	[204.202.242.120]) by ozlabs.org (Postfix) with SMTP id 9710468505
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Oct 2005 12:01:17 +1000 (EST)
Received: from mx14.stngva01.us.mxservers.net (204.202.242.37)
	by mail19d.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id 3-04976873
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Oct 2005 22:01:14 -0400 (EDT)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 7 Oct 2005 19:00:58 -0700
Message-ID: <000001c5cbac$20e66270$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20051007020004.517E8684D1@ozlabs.org>
Subject: porting 82xx HCI driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Everyone,

I am attempting to port the 8xx HCI driver over to the MPC8280, and have it
compiling...

However, there are a few functions that seem to be missing, that are
implicitly defined... These are just warnings during a compile but turn up
as errors when attempting to load the modules...

I was curious if it was just a missing piece of the kernel that I have not
included in the build.


Here are a few of the functions...

stop_sof_timer
ack_sof_timer
assert_reset
board_stop_force_disconnect


I have done a complete text search on the kernel source I have for 2.4.25
and haven't turned up anything.

Any ideas?

-Russ
