Message-ID: <32814.80.7.99.14.1087579617.squirrel@www.solinno.co.uk>
In-Reply-To: <20040618153506.GD811@smtp.west.cox.net>
References: <1831.80.7.99.14.1086886556.squirrel@www.solinno.co.uk>
    <20040617161616.GK24479@smtp.west.cox.net>
    <20040617223626.GB21217@iram.es>
    <20040618153506.GD811@smtp.west.cox.net>
Date: Fri, 18 Jun 2004 18:26:57 +0100 (BST)
Subject: Re: [RFC][PATCH 3/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Gabriel Paubert" <paubert@iram.es>,
	linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini said:
> On Fri, Jun 18, 2004 at 12:36:26AM +0200, Gabriel Paubert wrote:
>> On my PreP machines (well PowerPlus since they are actually
>> Raven/Falcon or Hawk based), the residual data for interrupt
>> routing is correct, but some people insisted in writing code
>> without having read the spec, and refused mine which correctly
>> decoded this information :-(
>
> Fixing things up to follow the spec, so long as there's not a good
> reason to not follow the spec (e.g. more machines have out-of-spec data,
> than do), maybe it'll get in now. :)

What would be useful for me would be having a copy of the  residual
data for a few Motorola machines...  (the residual data on my
powerstack works fine).

My approach for machines with duff residual data wasn't going to
be blacklisting, but working around problems with particular
machines.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
