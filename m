Date: Mon, 1 Mar 1999 21:38:30 -0800
From: Sean Harding <sharding@gutenberg.uoregon.edu>
Reply-To: Sean Harding <sharding@oregon.uoregon.edu>
To: "P. Barrette" <barretp@mcmail.cis.McMaster.CA>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: platinum video card not in kernels >2.1.128?
In-Reply-To: <Pine.SOL.3.96.990301170514.17781A-100000@mcmail.cis.McMaster.CA>
Message-ID: <Pine.SGI.4.10.9903012137000.29072-100000@gutenberg.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 1 Mar 1999, P. Barrette wrote:

> I've been told that the new kernels 2.2.x no longer support the platinum
> video driver which the 7200 uses;  but I note that there is a platinum
> option in the config.  Since I have no OF and serial output dumps garbage

It works fine for me. The video shoudn't be the problem. The 7200 does
have OF, you just can't have it output to the screen. If you're getting
garbage from the serial port, your terminal probably isn't configured
correctly.

sean

-- 
Sean Harding sharding@oregon.uoregon.edu|"art may imitate life
http://gladstone.uoregon.edu/~sharding/ | but life imitates t.v."
Consulting: http://www.efn.org/~seanh/  | --ani difranco


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
