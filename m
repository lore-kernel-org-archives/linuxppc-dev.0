Message-ID: <3C591CFB.8030404@elsoft.ch>
Date: Thu, 31 Jan 2002 11:31:23 +0100
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] 2 patches against linuxppc_dev-2.4.18-pre7
Content-Type: multipart/mixed;
 boundary="------------000505000302060103000004"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------000505000302060103000004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

In yesterday's e-mail the following 2 patches against linuxppc_dev-2.4.18-pre7
were missing:


    - arch/ppc/mm/fault.c
       missing type cast

    - arch/ppc/mm/cachemap.c
       missing prototype for map_page() (added mmu_decl.h)
       2 missing type casts


Dave



--------------000505000302060103000004
Content-Type: application/octet-stream;
 name="linuxppc.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linuxppc.patch.bz2"

QlpoOTFBWSZTWbW4/NoAAPnfgGAweX///2rd3AC/7//+QAK0nbZSy0wlII1NMmQjwk8oPQI0
A00AAaPRNNBJCIaJoGqemCj1PKAbSaAGg0GQBocZMmTEYmAEyYJkANGEYAhgEpqTJok2p6aT
0E0aBpoAAZNANBoA4bgYFkx1ohM8P6giIkzM24fg+EKIZlwZnhzQjZRRsobdNot87twAtq71
FJ4Svn4P1YjDilCHJulNKlavnHlcQtIySxaeZfLzlZnakzE2330lziIqhhjMF5l7Z6wiKsRB
FsUsGLuXdXOb1G3C/d0Zef7eDOyL8W98BvypXT/ddq0T0V0IZ6O2SUPPWeQtXOmLpZgykncY
cKywU1GjYxCZEzYwROEwThbnSFWiiWm/hJtNEnEoEXXxqvKfzAwNCRIvQN0jQXQ+yYYLa5Fh
nGtGLbO87PSjklJmCss4xTixVMoylcYTaDgjWsyB1JjBMyARhLpZblAeDwzehd7vDz8/IeSk
Z2mtZ3STuOEhigJrRnePPEoKz5ImXSO05Gl30ORzELlSxEIXlUVUn1JriwXoIYbEXB1HXd0K
YcwshaG0HUWWdXkAuAVzNgKrjSPFMOYKCJBnVxIBE7ChsqL46LXU5Jj+EDiQplQ5pgRYCDOC
bTar5xF/wJ2Zc+CaMOswNMsoaEJygOm06hMMXC0LkRSJYhgaPRkawdssS4xJi7Mk5aNY8EzD
Jnxzb6iWJICdr0gUo5HGFEiFQFX6VVpW0SHXBBGldSbTOs01yBMIQxK8fYdq82FSgNCs43K0
ZNjos/d2LAvwUDbGV4ZESM5VgsgS1CkhI8E0GrfqDy9bJMTNvbg1bRXmIy02Nw5NFcshhKp1
rstugzWEzYmtkxUQQFekrIYYddl4V2q4nUqb1t1Qsa7Ma078efAwcLay2MlaZXC0nvl98aQq
/xdyRThQkLW4/No=
--------------000505000302060103000004--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
