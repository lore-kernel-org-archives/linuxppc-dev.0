Date: Wed, 30 Jan 2002 10:44:35 +0100
Subject: Re: Support for new Dual G4 1 Gig machines?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>
From: Alain RICHARD <alain.richard@equation.fr>
In-Reply-To: <20020129190809.18610@mailhost.mipsys.com>
Message-Id: <F83E36A3-1565-11D6-8E33-0030657D0D7C@equation.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just for information, why do you consider sungem better than gmac ? What
kind of functionnalities is it supposed to better handle than gmac ?

Also about the video cards, there is two options :

- ATI Radeon 7500 (32 Mo)
- NVIDIA GeForce4 MX (64 Mo of RAM)

Is there any clue about the support of each one ?

For information, I have used NVidia cards under intel linux boxes and it
is very boring having to get the driver from Nvidia and to patch the
kernel and the XFree with their driver. Also I don't think they produce a
driver for ppc linux.

Le mardi 29 janvier 2002, à 08:08 , benh@kernel.crashing.org a écrit :

>
>>
>>> You should also use sungem preferably to the old gmac driver.
>>
>> Do you suspect that this is what is causing my crashes when the box is
>> exposed to moderately high network volume?
>
> Maybe, only tests will prove me right or wrong.
>
> Ben.
>
>
>
>
-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
