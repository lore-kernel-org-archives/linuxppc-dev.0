Date: Thu, 26 Aug 1999 13:26:24 -0400
From: Kevin Puetz <puetzk@iastate.edu>
To: Diego Laverde <dlaverde@uniandes.edu.co>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: EtherTalk Printers and SAMBA
Message-ID: <19990826132624.C4924@puetz.penguinpowered.com>
Reply-To: Kevin Puetz <puetzk@iastate.edu>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Of course not - the two hardly interact.

papd allows you to print (from Linux) to the Ethertalk printer - get this to work first. Then tell samba to print to that Linux printer.

I don't know details, but samba is just another program with a print job to spool as far as papd is concerned.

On Thu, 26 Aug 1999 08:56:25 Diego Laverde wrote:
> 
> Hellow,
> 
> I will like to share my Ether Talk printers whit Windows users, I have
> installed papd, but in the documentation din't say noting about SAMBA.
> 
> Can you help me?
> 
> Diego Laverde
> Universidad de los Andes
> Bogota, Colombia
> 
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
