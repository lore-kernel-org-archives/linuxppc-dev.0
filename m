Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C8643B7.60506@embeddededge.com>
Date: Wed, 06 Mar 2002 11:28:39 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: laurent.pinchart@capflow.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.4.18 & copy-back cache mode
References: <3C85DE01.6000006@capflow.com> <3C862D12.2080304@embeddededge.com> <3C8637A2.7020401@capflow.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Laurent Pinchart wrote:


> It's a Rev. D.3

Hmmmm....I regularly use one of those for testing (maybe it's an 855T),
and it seems OK for me.  The first one I had didn't work well, but
it was tracked down to a UPM/SDRAM timing problem.  People keep talking
about running > 50 MHz bus on these newer parts, is there something
different about the memory controller that allows this and may cause
compatibility problems?  I have (fortunately :-) not looked at this
level of detail in the newer parts.

When you disable copyback you also disable burst mode write from
the CPU core.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
