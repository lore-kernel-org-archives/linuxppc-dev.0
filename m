From: Benjamin Herrenschmidt <bh40@calva.net>
To: Joseph Garcia <jpgarcia@execpc.com>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: future of drivers/macintosh (was Re: CONFIG_PPC != Mac)
Date: Thu, 3 Aug 2000 00:02:45 +0200
Message-Id: <20000802220245.20854@mailhost.mipsys.com>
In-Reply-To: <398895AC.C6576613@execpc.com>
References: <398895AC.C6576613@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I don't think there's real need anymore for an adb directory. The only
>> file in it would be adb.c. The mouse and kbd drivers are moving to input,
>> the controller drivers (Cuda,PMU) do not only ADB but all sort of other
>> machine admin tasks (like power control, I2C, ...) and so are needed even
>> whithout ADB support as part of "PowerMac" support. Cuda can be shared
>> with m68k, maybe PMU too, so drivers/macintosh is not a so bad place
for it.
>
>would it be a prudent move to relocate most of drivers/macintosh to
>drivers/char, with the exception of mediabay.c to drivers/block/mac-
>mediabay.c?
>
>Something that fits the current layout scheme in a bi-partisan way.

Hum... The system controllers are not char drivers (well, PMU can be
occasionally), mediabay is not really a block driver, and I fell those
generic char and block drivers are already quite messy.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
