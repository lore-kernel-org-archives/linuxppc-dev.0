Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 04CC167A76
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 05:10:04 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 8 Mar 2005 11:10:03 -0700
To: Stephen Warren <SWarren@nvidia.com>, linuxppc-embedded@ozlabs.org
Message-ID: <20050308181003.GA1750@xyzzy>
References: <DBFABB80F7FD3143A911F9E6CFD477B0056A92B5@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B0056A92B5@hqemmail02.nvidia.com>
Subject: Re: MPC5200 kernel with IDE *and* FEC?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2005 at 05:34:20PM +0000, Stephen Warren wrote:
> I looked at the 2.6.11 kernel.org kernel, and it has MPC5200 IDE
> support, but apparently no FEC driver support.

Are you sure it has MPC5200 IDE support?  I have yet to see reliable
5200 IDE support and haven't seen a 5200 IDE driver for 2.6 at all.

I did the FEC driver in Sylvain's tree.  He has promised to push
it to kernel.org RSN.

-Dale Farnsworth
