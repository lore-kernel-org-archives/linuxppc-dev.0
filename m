Date: Thu, 11 Feb 1999 10:16:30 -0600 (CST)
From: Gedanken <gedanken@io.com>
To: Francis Augusto Medeiros <francis@mgate.com.br>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: My Linux is not obeying me !!!!!!
In-Reply-To: <199902111459.MAA20513@feijao.mgate.com.br>
Message-ID: <Pine.BSF.4.02A.9902111014370.699-100000@schultz.io.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



There is a script, in /etc/rc.d/  called rc.local that is run at boot up
that overwrites it.  change it in rc.local and youre in business.  I know
this from getting ticked off at my linux box for the same thing :)


gedanken
----
Heaven and Earth are impartial;
They see the ten thousand things as straw dogs.
The wise are impartial;
They see the people as straw dogs.

ICQ:  25437703


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
