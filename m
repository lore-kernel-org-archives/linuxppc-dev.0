From: Benjamin Herrenschmidt <benh@mipsys.com>
To: <daenzerm@student.ethz.ch>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: memory pb on Pismo... rumors or reality...
Date: Wed, 24 May 2000 14:23:29 +0200
Message-Id: <20000524122329.25951@mailhost.mipsys.com>
In-Reply-To: <392BBEE3.B0091F67@relog.ch>
References: <392BBEE3.B0091F67@relog.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 24, 2000, Michel Dänzer <daenzer@relog.ch> wrote:

>>
>> But this is not related to the memory pb... as you have 64 meg only. My
>> question was more about the risk of "numerous" chrashes on a machine with 2
>> memory banks. (as this was reported here a while ago).
>
>AFAIR the cause for the lockups hasn't been determined yet, and I'm a counter
>example for the theory that it's caused by certain memory configurations.

The Lombard problem may be a different issue. Paul told me his Lombard
powerbook used to have random garbage appearing in memory at a certain
location, he changed his motherboard (not the RAM module) 3 times before
getting one that didn't exhibit this behaviour :( that sucks !

The Pismo uses a completely different memory controller. It may have a
similar problem however...

------------------ RFC822 Header Follows ------------------
From: Benjamin Herrenschmidt <benh@mipsys.com>
To: <daenzerm@student.ethz.ch>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: memory pb on Pismo... rumors or reality...
Date: Wed, 24 May 2000 14:22:58 +0200
Message-Id: <20000524122258.22431@mailhost.mipsys.com>
In-Reply-To: <392BBEE3.B0091F67@relog.ch>
References: <392BBEE3.B0091F67@relog.ch>
X-Mailer: CTM PowerMail 3.0.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
-----------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
