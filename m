Message-ID: <3F58B305.7050007@kegel.com>
Date: Fri, 05 Sep 2003 09:00:05 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: zjzhou@newrocktech.com
Cc: "'Jaap-Jan Boor'" <jjboor@aimsys.nl>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: display top CPU processes top tool
References: <000201c3738f$5bcfd2d0$9702a8c0@newrock2>
In-Reply-To: <000201c3738f$5bcfd2d0$9702a8c0@newrock2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Zhou wrote:
> Jaap-Jan wrote:
>> On vrijdag, sep 5, 2003, at 10:26 Europe/Amsterdam, John Zhou wrote:
>>>top: Unknown terminal "ansi" in $TERM
>>>top: Unknown terminal "VT100" in $TERM
>>
>> Do you have a /etc/TERMCAP ?
>
> Yes. I have a /etc/TERMCAP. But it's still failed. need other changes ?

Use strace to see what it's looking for.
- Dan


--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
