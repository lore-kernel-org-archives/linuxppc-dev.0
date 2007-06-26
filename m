Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1182864764.19501.7.camel@weaponx.rchland.ibm.com>
References: <20070625182304.GC31840@mag.az.mvista.com>
	<1182796800.23775.51.camel@weaponx.rchland.ibm.com>
	<0FBD8D7C-1A60-4305-992C-5C28ECE41278@kernel.crashing.org>
	<1182804609.20939.5.camel@weaponx.rchland.ibm.com>
	<b75c4d9610522f1a45ed1e65c9a4a548@kernel.crashing.org>
	<1182864764.19501.7.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1ce7f225511ea3d67a63b8a4ac683e0c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [CURIOUSITY] When will we stop caring about arch/ppc?
Date: Tue, 26 Jun 2007 15:46:58 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> But I meant adding
>>> something in the Documentation/powerpc/ directory and maybe
>>> feature-removal-schedule.txt.  Basically a written down thing in the
>>> kernel source to refer people to.
>>
>> How about this time next year -- special event at
>> the OLS PowerPC BOF :-)
>
> Heh, sounds good to me.
>
> Of course, getting stuff done in a year.... ;)

Well the arch/ppc tree is basically frozen already, all Freescale
stuff got moved over already as far as I can see, and 4xx has
started moving.  I think a year is enough, since the tree is
frozen anyway, people can resurrect stuff from older releases
if need be, no problem with deleting it.  In fact, why not do
so this year :-)  [Yeah that was a joke].


Segher
