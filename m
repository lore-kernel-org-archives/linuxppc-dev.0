Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080506140656.7cff910c.sfr@canb.auug.org.au>
References: <20080425134805.GP6692@pengutronix.de>
	<20080505011607.GA9349@yookeroo.seuss>
	<1328d38bed8a830af756850bbaf2e8ad@kernel.crashing.org>
	<fa686aa40805051238n7df0c24fmc9fabeef4b7f6c63@mail.gmail.com>
	<20080506140656.7cff910c.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4df1ef3575f95f1daf2d67e237ead667@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add Phytec pcm030 board support
Date: Tue, 6 May 2008 07:51:55 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> PowerPC? check.
>> Sparc? check.
>> Microblaze? check.
>
> OLPC? check?

No check.  The kernel hardly uses the device tree at all, there.


Segher
