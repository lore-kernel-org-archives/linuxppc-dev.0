Message-ID: <XFMail.20030716121644.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20030716093646.GF7926@plato.local.lan>
Date: Wed, 16 Jul 2003 12:16:44 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Ethan Benson <erbenson@alaska.net>
Subject: Re: G4 mdd help request
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 16-Jul-2003 Ethan Benson wrote:
>
> On Wed, Jul 16, 2003 at 11:09:40AM +0200, Giuliano Pochini wrote:
>>
>> I bought a dual G4-MDD and I installed my SCSI disk I used on
>> my G3. Is there an osx command to get the openfirmware path of
>> the yaboot partition on that disc ?  I tried to boot
>> /pci@f2000000/ADPT,29160@12/@4:9,ofboot.b but it doesn't work.
>> Macosx mounts the HFS partitions on the old disc, but it doesn't
>> show any of them on the startup disk utility (does it need to be
>> blessed again ?).
>
> the yaboot bootstrap partition should be type Apple_Bootstrap and thus
> never mounted by any macos, if this is the case there is no need to
> rebless it since macos never tampered with it.

IIRC it's Apple_Bootstrap, but first of all I must know the correct
ofpath... I also tried to boot the YDL2.3 cd without success :(

> now if you didn't follow directions and made it an Apple_HFS then
> macos probably broke it yes.

I'll try to get osx root access.


Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
