Message-Id: <199907291407.HAA09629@meer.meer.net>
Subject: Re: G3 Upgrade Questions....
Date: Thu, 29 Jul 1999 09:11:15 -0500
From: David DeHaven <daved@trestle.com>
To: <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>	i have a powercenter 132, is it feasable that the 
>	motherboard can only run a 200MHz CPU or is the
>	card being set to half speed some how?
>
>	under MacOS it says it is at 400 and when i run
>	MacBench i get the numbers a little lower than
>	what the box says ( like 25 points low ).
>
>	under LinuxPPC my setiat home client takes almost
>	24h to process a block while my P][ 400 takes
>	only 10 hours....
>
>	is this the client?
>	am i really running half as fast?
>
>	should i send this bugger back and just get
>	a 200Mhz one because that is all my board can	
>	do?
>
>	thanks for the input all.

ian,

Go to http://www.newertech.com, click on the "Downloads" button on the 
left side, click on "Guage Utilities" and download "Clockometer". This 
will give you an accurate measurement of your CPU's clock. You can also 
try "Cache-22" to see if your L2 cache is really being enabled. If it 
shows up at 400MHz, then it's working properly.

-DrD-

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
