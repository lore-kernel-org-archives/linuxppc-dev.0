Message-ID: <3F0A8B40.8000706@dgt-lab.com.pl>
Date: Tue, 08 Jul 2003 11:13:36 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem installing Denx Eldk on Mandrake 9.1
References: <20030708000947.48998.qmail@web10010.mail.yahoo.com>
In-Reply-To: <20030708000947.48998.qmail@web10010.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>
>Is it because of Mandrake 9.1?
>
>
>
>
Yes. They (mandrake maintainers) like newer versions of rpm, and it have
some problems with redirection

try:
for f in *.rpm;do rpm -hiv $f --force --nodeps --relocate /=/opt/eldk;done

if this won't  help rename  /var/lib/__db*

another method is downgrade rpm (sorry dont remember version)

my sollution was copy /opt/eldk from previous installation on another
machine

--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
