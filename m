Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080520005401.GD22279@yookeroo.seuss>
References: <1211136296-4572-1-git-send-email-galak@kernel.crashing.org>
	<0B367446-4628-4633-BF66-A0007BD9A98B@kernel.crashing.org>
	<18482.2082.900892.368978@cargo.ozlabs.ibm.com>
	<20080520005401.GD22279@yookeroo.seuss>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ec2c238ae4182d7546da3519fbf90158@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 0/4] minor fixes for 2.6.26
Date: Tue, 20 May 2008 04:03:47 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I think that adding zImage.* to clean-files is a bad idea, because we
>> have zImage.lds.S, zImage.coff.lds.S and zImage.ps3.lds.S in
>> arch/powerpc/boot that we don't want deleted.  It would be OK for
>> compiling with a separate object directory but would be bad for
>> compiling in the source directory.
>
> Arguably this suggests we should rename either the lds files or the
> zImages so that we *can* get a pattern to match.

Not really.  Just define a $(ALL_ZIMAGES) var and use that everywhere.
I would be pretty upset if "make clean" decided to delete my 
zImage.backup,
etc.


Segher
