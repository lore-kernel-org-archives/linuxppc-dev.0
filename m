Message-ID: <3EA69F7B.1080607@mvista.com>
Date: Wed, 23 Apr 2003 09:13:15 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Aman <aman@mistralsoftware.com>
Cc: Martin Hicks <mort@bork.org>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Serial Console Login Fails
References: <001301c3093d$ad9c69f0$370da8c0@aman> <20030423123015.GI553@bork.org> <3EA68E1E.7090201@mvista.com> <001701c3099e$c1f900f0$370da8c0@aman>
In-Reply-To: <001701c3099e$c1f900f0$370da8c0@aman>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Aman wrote:
> Hi Martin
>
> I have the etc/securetty file with entry ttyS0. Actually I cant see the log
> messages since the linux boots up and gets struck in the login itself . Is
> there any other way to get the log messages. In my board , I don't have
> network support. So each I time I have to modify the ramdisk image and run
> it. I tried putting in /bin/login, however I getting the following error
> "/bin/login: error while loading shared libraries: cannot open shared object
> file
> : cannot load shared object file: No such file or directory"
> I think the related shared libraries is not there , how to find related
> shared libraries for any file.

<target>-objdump -p <filename> | grep NEEDED

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
