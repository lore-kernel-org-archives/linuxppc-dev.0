Message-ID: <3F58BC4A.1020509@mvista.com>
Date: Fri, 05 Sep 2003 11:39:38 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
Cc: zjzhou@newrocktech.com, "'Jaap-Jan Boor'" <jjboor@aimsys.nl>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: display top CPU processes top tool
References: <000201c3738f$5bcfd2d0$9702a8c0@newrock2> <3F58B305.7050007@kegel.com>
In-Reply-To: <3F58B305.7050007@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I bet that top is linked with ncurses instead of termcap.  As such look
at /usr/share/terminfo on the target and make sure the appropriate
directories and terminal emulations are there.

--Mark

Dan Kegel wrote:
>
> John Zhou wrote:
>
>> Jaap-Jan wrote:
>>
>>> On vrijdag, sep 5, 2003, at 10:26 Europe/Amsterdam, John Zhou wrote:
>>>
>>>> top: Unknown terminal "ansi" in $TERM
>>>> top: Unknown terminal "VT100" in $TERM
>>>
>>>
>>> Do you have a /etc/TERMCAP ?
>>
>>
>> Yes. I have a /etc/TERMCAP. But it's still failed. need other changes ?
>
>
> Use strace to see what it's looking for.
> - Dan
>
>
> --
> Dan Kegel
> http://www.kegel.com
> http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
