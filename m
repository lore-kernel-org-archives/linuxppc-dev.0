Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1DB0168A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 10:40:30 +1100 (EST)
To: marty.wedepohl@shaw.ca
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problem getting code from git repository 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 23 Jan 2006 13:56:20 MST."
	<1f82ba6e0601231256s15cb73dehdb6dd53ed50c38de@mail.gmail.com>
Date: Thu, 26 Jan 2006 00:40:28 +0100
Sender: wd@denx.de
Message-Id: <20060125234028.1CBC3352584@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1f82ba6e0601231256s15cb73dehdb6dd53ed50c38de@mail.gmail.com> you wrote:
> When I attempt to retrieve the current source from the git repository
> I get the following
> 
> Any suggestions ???  Martin

Do you use a current version of the  git  tools?  The  same  commands
worked  perfectly  fine for me when I checked ... I'm using git-1.1.2
and cogito-0.6.3 on a FC4 system:

-> rpm -qa | grep git
git-core-1.1.2-1.fc4
git-1.1.2-1.fc4
git-cvs-1.1.2-1.fc4
git-svn-1.1.2-1.fc4
git-arch-1.1.2-1.fc4
cogito-0.16.3-1.fc4
gitk-1.1.2-1.fc4
-> cd /tmp/
-> cg-clone http://www.denx.de/git/linux-2.6-denx.git linux-2.6-denx.git/
/tmp/linux-2.6-denx.git
defaulting to local storage area
Fetching head...
Fetching objects...
Getting alternates list for http://www.denx.de/git/linux-2.6-denx.git/
Getting pack list for http://www.denx.de/git/linux-2.6-denx.git/
Getting index for pack b3c6fbdfa36a326815de6358885c7a570a986b1b
Getting index for pack 459148e2ea863c15479d69ed4886a6f200c79a49
Getting index for pack ad1ecbdb18e6a825fafa9f57ebb11a5dbe6e12ef
Getting index for pack 2dae6bb81ac4383926b1d6a646e3f73b130ba124
Getting index for pack dcd74895edc829753c14248afdcc8537c7c62207
Getting pack dcd74895edc829753c14248afdcc8537c7c62207
 which contains 1c06cf5a9851a83493f5b5f3749b4ced4e07af29
Getting pack 2dae6bb81ac4383926b1d6a646e3f73b130ba124
 which contains 5014bfa48ac169e0748e1e9651897788feb306dc
Getting pack ad1ecbdb18e6a825fafa9f57ebb11a5dbe6e12ef
 which contains 7b7ed3723b67cacdad7d664ed4392339925810a3
Getting pack 459148e2ea863c15479d69ed4886a6f200c79a49
 which contains e12c24654003c0f3e033fe05ba6d703c01a992e3
Fetching tags...
Missing tag DENX-2005-10-02-1830... retrieved
Missing tag DENX-2005-12-03-2208... retrieved
Missing tag DENX-v2.6.15... retrieved
Missing tag v2.6.11-tree... retrieved
Missing tag v2.6.11... retrieved
Missing tag v2.6.12-rc2... retrieved
Missing tag v2.6.12-rc3... retrieved
Missing tag v2.6.12-rc4... retrieved
Missing tag v2.6.12-rc5... retrieved
Missing tag v2.6.12-rc6... retrieved
Missing tag v2.6.12... retrieved
Missing tag v2.6.13-rc1... retrieved
Missing tag v2.6.13-rc2... retrieved
Missing tag v2.6.13-rc3... retrieved
Missing tag v2.6.13-rc4... retrieved
Missing tag v2.6.13-rc5... retrieved
Missing tag v2.6.13-rc6... retrieved
Missing tag v2.6.13-rc7... retrieved
Missing tag v2.6.13... retrieved
Missing tag v2.6.14-rc1... retrieved
Missing tag v2.6.14-rc2... retrieved
Missing tag v2.6.14-rc3-BAD... retrieved
Missing tag v2.6.14-rc3... retrieved
Missing tag v2.6.14-rc4... retrieved
Missing tag v2.6.14-rc5... retrieved
Missing tag v2.6.14... retrieved
Missing tag v2.6.15-rc1... retrieved
Missing tag v2.6.15-rc2... retrieved
Missing tag v2.6.15-rc3... retrieved
Missing tag v2.6.15-rc4... retrieved
Missing tag v2.6.15-rc5... retrieved
Missing tag v2.6.15-rc6... retrieved
New branch: 1c06cf5a9851a83493f5b5f3749b4ced4e07af29
Cloned to linux-2.6-denx.git// (origin http://www.denx.de/git/linux-2.6-denx.git available as branch "origin")
-> echo RC=$?
RC=0




Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"This isn't brain surgery; it's just television."   - David Letterman
