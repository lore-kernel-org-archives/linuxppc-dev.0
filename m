Date: Sun, 15 Feb 2004 21:14:35 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Yang <yangqs@163.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: clock() seems not work !
Message-ID: <20040216051435.GA25104@gate.ebshome.net>
References: <200402160354.VAA15020@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402160354.VAA15020@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Feb 16, 2004 at 11:58:07AM +0800, Yang wrote:
>
>  i am writting applications based ppc+MVL3.0, which i want to get CPU
> time,but clock() seems not work for me, for this i did a simple test,as
> follows:
> /*----------------*/
>   while(1)
> 	{
>       printf("current time is %ld \n",clock());
> 	  sleep(1);
> 	}
> /*----------------*/
>      But it printed the same value all the while. How is it?
>

What do you expect from this function?

Did you read manual entry for clock()?

On POSIX systems clock() returns (number of seconds * CLOCKS_PER_SEC)
spent by the process, not a system time/tick count...

Your program is doing _nothing_, so it's normal that clock() returns
the same number. Change sleep(1) to some busy loop and you'll see the
difference.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
