Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 36DB0DDDED
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Sep 2008 03:36:02 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3248785rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Sep 2008 10:36:01 -0700 (PDT)
Date: Wed, 17 Sep 2008 10:35:55 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Shanyuan Gao <sygao.research@gmail.com>
Subject: Re: Back port Virtex5 FPU to Virtex4?
Message-ID: <20080917173555.GA7913@secretlab.ca>
References: <3C87E4F8-3DA2-41E8-BE33-979A7869FD2D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C87E4F8-3DA2-41E8-BE33-979A7869FD2D@gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 26, 2008 at 04:00:42PM -0400, Shanyuan Gao wrote:
> I am working with ML410 and have FPU (single precision) working.   
> However, the FPU for V5 looks more attractive because it's double  
> precision.  So is it possible to back port the double precision FPU to 
> V4?

As far as I understand there are limitations in the V4 APU interface
that makes the full double precision FPU unfeasible.  The Xilinx folks
can correct me if I'm wrong.

g.
