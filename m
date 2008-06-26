Return-Path: <adrian@rhlx01.hs-esslingen.de>
Date: Thu, 26 Jun 2008 09:21:11 +0200
From: Adrian Reber <adrian@lisas.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: starting with 2.6.26-rc1 cell_defconfig fails on QS22
Message-ID: <20080626072111.GA4412@lisas.de>
References: <20080623094539.GA16685@lisas.de>
	<200806240945.33255.jk@ozlabs.org>
	<20080624122929.GA10666@lisas.de>
	<132766c4280d49d0cef076e7444f6f11@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <132766c4280d49d0cef076e7444f6f11@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 25, 2008 at 05:59:33PM +0200, Segher Boessenkool wrote:
>> D'oh. I spent so much time and the solution is so easy.
>>
>> Thanks everybody. I have updated to binutils-2.18.50.0.6-2.ppc and now
>> it works again on QS22 and JS21.
>
> So I checked your binary, and the only differences between working and
> not-working are a) some section offsets in the file, and b) the load
> address of the segment (0 vs. 0xc000...).
>
> a) should be harmless, and b) likely is a binutils bug that got fixed.
>
> What is the exact binutils version you used for the non-working?  Should

I had two old Fedora installations. Both installations have been
updated, but looking at the installation tree it must have been
something like 2.16.91.0.6 and 2.17.50.0.3

> we test for it in our Makefile?  If we require 2.18, we can drop the tests
> for 2.12 and 2.14 ;-)

		Adrian
