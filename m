Message-ID: <XFMail.20030717124840.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20030717073956.GH7926@plato.local.lan>
Date: Thu, 17 Jul 2003 12:48:40 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Ethan Benson <erbenson@alaska.net>
Subject: Re: G4 mdd help request
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 17-Jul-2003 Ethan Benson wrote:
>> Of course I did, but I was unsure because dev / ls shows a leaf "/disk".
>> Yesterday night I managed to get from osx the of path, and it's about
>> the same I wrote above. I mounted the boot partition in /xyz, then I
>> wrote in a root shell:
>>
>> bless -folder9 /xyz -verbose -setOF
>
> NEVER mount bootstrap partitions in any macos, nor let macos ever
> touch it.  no good will ever result.

Who cares ?  For sir G4mdd it was (is) not a bootable partition. What
damage can it do ?  It already doesn't boot.


Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
