Date: Sat, 13 Feb 1999 11:19:36 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Gavriel State <u497w7n9@umail.furryterror.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Why is -msoft-float used in Kernel compilation?
Message-ID: <19990213111936.A1449@wogglebug.cygnus.com>
References: <199902131436.JAA07672@linuxmaster.corel.eng>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199902131436.JAA07672@linuxmaster.corel.eng>; from Gavriel State on Sat, Feb 13, 1999 at 09:37:46AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Feb 13, 1999 at 09:37:46AM -0500, Gavriel State wrote:
> 
> I can understand using -msoft-float if CONFIG__8xx is on,
> but why use it when compiling for 60x or 7x0 CPUs?

I would imagine to prevent the compiler from using the FPU to move 64-bit
aligned items via fp registers.

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
